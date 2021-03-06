#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os, sys, subprocess, uuid, shutil, fileinput, gi
gi.require_version("Notify", "0.7")
from joblib import Parallel, delayed
from gi.repository import GObject
from gi.repository import Notify
from chunks_epub import *


if __name__ == "__main__":

	paths=sys.argv[1:]
	translation=True
	
	my = MyNotification()
	my.send_notification("Epub tools", "Translation process in progress...")

	lang=detect_lang(paths)

	for p in sorted(paths):
		ebook=DesktopJob(p,lang)
		ebook.create_dir()
		ebook.split()
		ebook.epub2txt()
		ebook.translate()
		ebook.clean_null()
		ebook.txt2epub(ebook.tmp_txt_trans_files)
		ebook.word_count()
		ebook.create_chunks()
		ebook.clean_dir()

	
	my.send_notification("Epub tools", str(len(paths))+ " files have been translated and splitted in chunks!")




