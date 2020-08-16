
import os
import sys
import numpy as np
import subprocess
import shutil
import csv
import json
import re
import fileinput


def main():
    model= sys.argv[1]
    peeling = sys.argv[2]
    date = sys.argv[3]
    params = sys.argv[4]
    evaluator_path = "runs/" + model + "_" + peeling + "_" + date + \
    "/genetic_alg/hoc_evaluator.py"

    #we could make this a dictionary but simple and fast for now
    textToSearch = 'model=""'
    textToReplace = "model='" + model +"'"
    textToSearch2 = 'peeling=""'
    textToReplace2 = "peeling='" + peeling +"'"
    textToSearch3 =  'date=""'
    textToReplace3 =  "date='" + date + "'"
    textToSearch4 = "params_opt_ind="""
    textToReplace4 = "params_opt_ind=[" + params +"] \n"



    tempFile = open( evaluator_path, 'r+' )

    for line in fileinput.input( evaluator_path ):
        if textToSearch in line:
             print('modifying model')
             tempFile.write(line.replace(textToSearch, textToReplace))
             #print(line.replace(line, textToReplace))
        elif textToSearch2 in line:
             print('modifying peeling')
             tempFile.write(line.replace(textToSearch2, textToReplace2))
             #print(line.replace(line, textToReplace))
        elif textToSearch3 in line:
             print('modifying date')
             tempFile.write(line.replace(textToSearch3, textToReplace3))
        elif textToSearch4 in line:
             print('modifying params')
             tempFile.write(line.replace(line, textToReplace4))
        else:
            tempFile.write(line)

    tempFile.close()




if __name__ == '__main__':
    main()
