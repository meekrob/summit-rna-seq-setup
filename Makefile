SUMMIT_ROOT=/scratch/summit/${USER}/DSCI512_QC/02_output
FASTQC_OUTDIR=${SUMMIT_ROOT}/01_fastqc
TRIMMO_OUTDIR=${SUMMIT_ROOT}/02_trimmomatic
default:
	@echo "Type 'make setup' to set up data paths, validate program availability and test job submission."
	@echo

setup: test-bin link-data test-sbatch
	@echo "Tests passed."

test-bin:
	@echo Testing \'source activate.bashrc\'
	@bash .test_activation.bash

test-sbatch:
	@echo "Testing job submission..."
	@cd .test_environ && bash test_job_submission.bash

link-data:
	@echo "Linking to input data directory..."
	@[ -e 01_input ] && echo "OK" || ln -sv /scratch/summit/erinnish@colostate.edu/EOP230_DSCI512_test/DSCI512_RNAseqAnalyzers/01_input .
	@echo "Creating output directories"
	@echo "02_output/01_fastqc..."
	@[ -e ${FASTQC_OUTDIR} ] && echo "OK" || mkdir -pv ${FASTQC_OUTDIR}
	@echo "02_output/02_trimmomatic..."
	@[ -e ${TRIMMO_OUTDIR} ] && echo "OK" || mkdir -pv ${TRIMMO_OUTDIR}
	@echo "linking to current directory: 02_output..."
	@[ -e 02_output ] && echo "OK" || ln -sv ${SUMMIT_ROOT} .
	@echo "Done linking data directories."

test-sbatch-fail:
	@echo "Testing job submission failure..."
	@cd .test_environ && bash test_job_submission.bash fail
