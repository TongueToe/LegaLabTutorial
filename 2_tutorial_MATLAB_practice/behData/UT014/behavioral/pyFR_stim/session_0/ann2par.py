#!/usr/bin/env python
import os
import sys
from optparse import OptionParser

usage = "Usage: ann2par.py file1.ann [file2.ann file3.ann ..]\n\n" +\
        "For each ann file, a par file is generated."

optParse = OptionParser(usage=usage)
(opts, args) = optParse.parse_args()

if len(args) == 0:
    optParse.error("Please specify at least one .par file.")

files = []
for i in range(len(args)):
    file = os.path.expanduser(args[i])
    if not os.access(file, os.F_OK):
        sys.exit("The file '%s' doesn't exist." % file)
    files.append(file)

for file in files:
    parFile = file[:-4] + ".par"
    (dir, filename) = os.path.split(file)
    annFile = open(file,'r')
    parFile = open(parFile,'w')
    annLines = annFile.readlines()
    for annLine in annLines:
        if annLine[0] != '#':
            annLine = annLine.replace('\n','')
            annLine = annLine.split('\t')
            if annLine[0] != '':
                if annLine[2][0] == '<':
                    annLine[2] = 'VV'
                line = str(int(round(float(annLine[0])))) + '\t' + \
                       str(int(annLine[1])) + '\t' + annLine[2] + '\n'
                parFile.write(line)
    parFile.close()
            
