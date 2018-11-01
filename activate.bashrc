# Make absolute path
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


