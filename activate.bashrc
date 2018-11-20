# Make absolute path
# ${BASH_SOURCE[0]} is the actual name of this file
# realpath is a command to get the fully qualified, absolute path
# dirname returns the full path minus the final, file path.
PROJECT_DIR=$(dirname $(realpath ${BASH_SOURCE[0]}))

# add base bin directory to path
# includes:
#   trimmomatic 
#   samtools
PATH=${PATH}:${PROJECT_DIR}/bin
ml jdk # for FastQC, trimmomatic
ml gcc # for samtools

# add FastQC 
PATH=${PATH}:${PROJECT_DIR}/bin/FastQC

# add bedtools
PATH=${PATH}:${PROJECT_DIR}/bin/bedtools

# add hisat2
PATH=${PATH}:${PROJECT_DIR}/bin/hisat2

# add subread
PATH=${PATH}:${PROJECT_DIR}/bin/subread

# PYTHONPATH: Include the curc/sw version package
BX_ENV="/projects/dcking@colostate.edu"
export PYTHONPATH=$BX_ENV/python_compat # site.py within this directory will detect python version and then explicitly set the py2/py3 using sys.path
# python binaries: have to put both versions in the path, 2 before 3, making 2.7 the default and require python3 to be called as such
PYTHON2_PATH=/curc/sw/python/2.7.11/bin
PYTHON3_PATH=/curc/sw/python/3.5.1/bin
export PATH=$PYTHON2_PATH:$PYTHON3_PATH:$PATH
