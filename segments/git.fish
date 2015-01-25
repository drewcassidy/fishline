#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-

function FLSEG_GIT

	if [ $FLINT_GIT -eq 0 ]

		set -l gitstatus (git status ^ /dev/null | \
		awk 'BEGIN {d=0; s=0; ns=0; u=0; a=0; b=0};\
		/On branch \w+/ {m=$3}; \
		/HEAD detached from \w+/ {m=$4;d=1}; \
		/Changes to be committed:/ {s=1}; \
		/Changes not staged for commit:/ {ns=1}; \
		/Untracked files:/ {u=1}; \
		/Your branch is ahead/ {a=$8}; \
		/Your branch is behind/ {b=$8}; END {print d, m, s, ns, u, a, b}' \
		| sed 's/ /\n/g' )

		# bool gitstatus[1] detached
		# str  gitstatus[2] branch name
		# bool gitstatus[3] staged changes
		# bool gitstatus[4] unstaged changes
		# bool gitstatus[5] untracked files
		# int  gitstatus[6] numbers of commit ahead from head
		# int  gitstatus[7] numbers of commit behind from head

		if [ $gitstatus[1] -eq 1 ]
			set state Detached
		else if test $gitstatus[3] -eq 1 -o $gitstatus[4] -eq 1 -o $gitstatus[5] -eq 1
			set state Dirty
		else
			set state Clean
		end

		switch $state
			case Dirty
				FLINT_CLOSE $FLCLR_GIT_BG_DIRTY $FLCLR_GIT_FG_DIRTY
				echo -n " $FLSYM_GIT_BRANCH "
			case Detached
				FLINT_CLOSE $FLCLR_GIT_BG_DETACHED $FLCLR_GIT_FG_DETACHED
				echo -n " $FLSYM_GIT_DETACHED "
			case '*'
				FLINT_CLOSE $FLCLR_GIT_BG_CLEAN $FLCLR_GIT_FG_CLEAN
				echo -n " $FLSYM_GIT_BRANCH "
		end

		
		echo -n "$gitstatus[2] "
		if [ $gitstatus[6] -gt 0 ]
			echo -n "$gitstatus[6]$FLSYM_GIT_AHEAD "
		end
		if [ $gitstatus[7] -gt 0 ]
			echo -n "$gitstatus[7]$FLSYM_GIT_AHEAD "
		end
		if [ $gitstatus[5] -eq 1 ]
			echo -n "$FLSYM_GIT_UNTRACKED "
		else if [ $gitstatus[4] -eq 1 ]
			echo -n "$FLSYM_GIT_UNSTAGED "
		else if [ $gitstatus[3] -eq 1 ]
			echo -n "$FLSYM_GIT_STAGED "
		end
	end

end