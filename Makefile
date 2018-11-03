default:
	@echo "Type 'make test' to validate program availability and job submission."
	@echo

test:
	@bash .test_activation.bash
	@echo
	@echo "Testing job submission..."
	@cd .test_environ && bash test_job_submission.bash
	@echo "Linking to input data directory..."
	@[ -e 01_input ] && echo "OK" || ln -sv /scratch/summit/erinnish@colostate.edu/EOP230_DSCI512_test/DSCI512_RNAseqAnalyzers/01_input .
	@echo "Tests passed."

fail:
	@echo "Testing job submission failure..."
	@cd .test_environ && bash test_job_submission.bash fail
