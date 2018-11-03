default:
	@echo "Type 'make test' to validate program availability and job submission."
	@echo

test: test-bin test-data test-sbatch
	@echo "Tests passed."

test-bin:
	@echo Testing \'source activate.bashrc\'
	@bash .test_activation.bash

test-sbatch:
	@echo "Testing job submission..."
	@cd .test_environ && bash test_job_submission.bash

test-data:
	@echo "Linking to input data directory..."
	@[ -e 01_input ] && echo "OK" || ln -sv /scratch/summit/erinnish@colostate.edu/EOP230_DSCI512_test/DSCI512_RNAseqAnalyzers/01_input .

test-sbatch-fail:
	@echo "Testing job submission failure..."
	@cd .test_environ && bash test_job_submission.bash fail
