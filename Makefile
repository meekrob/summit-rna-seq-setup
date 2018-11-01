default:
	@echo "Type 'make test' to validate program availability and job submission."
	@echo

test:
	@bash .test_activation.bash
	@echo
	@echo "Testing job submission..."
	@cd .test_environ && bash test_job_submission.bash
	

fail:
	@echo "Testing job submission failure..."
	@cd .test_environ && bash test_job_submission.bash fail
