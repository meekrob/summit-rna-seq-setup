#!/usr/bin/env bash

test_script=always_passes.sbatch

if [ -n "$1" ] && [ $1 == "fail" ]
then
    # fail: no such script
    test_script=never_passes.sbatch
fi

if ! sbatch $test_script &> err.msg
then
    echo "Job submission failed"
    cat head.msg err.msg tail.msg | mailx -s "Job submission failed for $USER" dcking@colostate.edu 
    cat err.msg
else
    echo "Job submission passed"
    rm err.msg
fi
