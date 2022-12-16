# Author: Rafael Cavalcanti <https://rafaelc.org/dev>

import os
from ranger.core.loader import CommandLoader
from ranger.api.commands import Command
from ranger.ext import spawn
from subprocess import CalledProcessError

# Copied from https://wiki.archlinux.org/index.php/Ranger#Compression
class compress(Command):
    def execute(self):
        """ Compress marked files to current directory """
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path
        parts = self.line.split()
        au_flags = parts[1:]

        descr = "compressing files in: " + os.path.basename(parts[1])
        obj = CommandLoader(args=['apack'] + au_flags + \
                [os.path.relpath(f.path, cwd.path) for f in marked_files], descr=descr, read=True)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self, tabnum):
        """ Complete with current folder name """

        extension = ['.zip', '.tar.gz', '.rar', '.7z']
        return ['compress ' + os.path.basename(self.fm.thisdir.path) + ext for ext in extension]

# Adapted from <https://github.com/ranger/ranger/wiki/Custom-Commands> (mkcd)
class take(Command):
    """
    :take <dirname>

    Creates a directory with the name <dirname> and enters it.
    """

    def execute(self):
        from os.path import join, expanduser, lexists
        from os import makedirs
        import re

        dirname = join(self.fm.thisdir.path, expanduser(self.rest(1)))
        if not lexists(dirname):
            try:
                makedirs(dirname)
            except PermissionError:
                self.fm.execute_command(f"sudo mkdir -p {dirname}")

            match = re.search('^/|^~[^/]*/', dirname)
            if match:
                self.fm.cd(match.group(0))
                dirname = dirname[match.end(0):]

            for m in re.finditer('[^/]+', dirname):
                s = m.group(0)
                if s == '..' or (s.startswith('.') and not self.fm.settings['show_hidden']):
                    self.fm.cd(s)
                else:
                    ## We force ranger to load content before calling `scout`.
                    self.fm.thisdir.load_content(schedule=False)
                    self.fm.execute_console('scout -ae ^{}$'.format(s))
        else:
            self.fm.notify("file/directory exists!", bad=True)


# Based on https://github.com/ranger/ranger/wiki/Custom-Commands
class fzf_select(Command):
    """
    :fzf_select

    Find a file in the repository root using fzf. If not in a repository, use the current directory.

    With a prefix argument select only directories.
    """
    def execute(self):
        import subprocess
        import os.path

        try:
            dir_to_search=spawn.check_output("git rev-parse --show-toplevel").strip()
        except CalledProcessError:
            dir_to_search="."

        if self.quantifier:
            # match only directories
            # cd so displayed names are cleaner
            command=f"cd '{dir_to_search}' && fd {os.environ['FD_ARGS']} --type d . | fzf +m --height 100%--margin '4%,5%'"
        else:
            # match files and directories
            command=f"cd '{dir_to_search}' && fd {os.environ['FD_ARGS']} . | fzf +m --height 100% --margin '4%,5%'"
        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(os.path.join(dir_to_search, stdout.rstrip('\n')))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

