TARGET=paper
GIT_HOOKS_DIR=.git/hooks
POST_CHECKOUT_FILE=$(GIT_HOOKS_DIR)/post-checkout
all: pdf

define POST_CHECKOUT_CMD =
#!/bin/sh
# Copyright 2014 Brent Longborough
# Part of gitinfo2 package Version 2
# Please read gitinfo2.pdf for licencing and other details
# -----------------------------------------------------
# Post-{commit,checkout,merge} hook for the gitinfo2 package
#
# Get the first tag found in the history from the current HEAD
FIRSTTAG=$(git describe --tags --always --dirty='-*' 2>/dev/null)
# Get the first tag in history that looks like a Release
RELTAG=$(git describe --tags --long --always --dirty='-*' --match '[0-9]*.*' 2>/dev/null)
# Hoover up the metadata
git --no-pager log -1 --date=short --decorate=short \
    --pretty=format:"\usepackage[%
        shash={%h},
        lhash={%H},
        authname={%an},
        authemail={%ae},
        authsdate={%ad},
        authidate={%ai},
        authudate={%at},
        commname={%an},
        commemail={%ae},
        commsdate={%ad},
        commidate={%ai},
        commudate={%at},
        refnames={%d},
        firsttagdescribe={$FIRSTTAG},
        reltag={$RELTAG}
    ]{gitexinfo}" HEAD > .git/gitHeadInfo.gin
endef
export POST_CHECKOUT_CMD

setup-gitinfo2:
ifneq ("$(wildcard $(GIT_HOOKS_DIR))","")
	@echo "$$POST_CHECKOUT_CMD" > $(POST_CHECKOUT_FILE)
	@chmod +x $(POST_CHECKOUT_FILE)
	@$(POST_CHECKOUT_FILE)
endif

pdf: setup-gitinfo2
	GS_OPTIONS=-dPDFSETTINGS=/prepress rubber -f --pdf -Wrefs -Wmisc $(TARGET)

clean:
	rm -f *.aux *.log *.out *.bbl *.blg *.brf *~ *.bak $(TARGET).pdf $(TARGET).ps $(TARGET).toc $(TARGET).lot $(TARGET).lof

cleanall: clean
	rm -f $(TARGET).pdf

ps: pdf
	GS_OPTIONS=-dPDFSETTINGS=/prepress pdftops -level1 $(TARGET).pdf
