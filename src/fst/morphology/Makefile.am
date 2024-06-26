## Process this file with automake to produce Makefile.in

## Copyright (C) 2011 Samediggi

## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

# build before test
SUBDIRS=. test

# Add language-specific flags for hfst-lexc compilation here:
if HAVE_SHARED_COMMON
HFST_LEXC_LOCAL_FLAGS=  # --Werror # uncomment if lexc is good enough
else
HFST_LEXC_LOCAL_FLAGS=  # No --Werror if deps are missing !
endif


####### Morphology source file defs: ########

GT_LEXD_ROOT=$(srcdir)/root.lexd

LEXD_FILES=\
		stems/verbs.lexd \
		stems/nouns.lexd \
		stems/pronouns.lexd \
		affixes/pronouns.lexd \
		stems/proper_nouns.lexd \
		affixes/verbs.lexd \
		affixes/determiners.lexd \
		affixes/nouns.lexd \
		stems/adjectives.lexd \
		stems/conjunctions.lexd \
		stems/particles.lexd \
		stems/toponyms.lexd \
		stems/prepositions.lexd \
		stems/interrogatives.lexd \
		stems/adverbs.lexd \
		stems/numbers.lexd
		

lexicon.tmp.lexd: $(GT_LEXD_ROOT) $(LEXD_FILES)
	$(AM_V_GEN)cat $^ > $@

lexicon.tmp.att: lexicon.tmp.lexd
	$(AM_V_LEXD)$(LEXD) $< $@

lexicon.tmp.hfst: lexicon.tmp.att
	$(AM_V_GEN)cat $< \
		| sed -E 's/\t<(@[A-Z]\.LEX\.[A-Za-z0-9]+@)>\t/\t\1\t/g' \
		| sed -E 's/\t<([^\t]+)>\t/\t+\1\t/g' \
		| $(HFST_TXT2FST) $(HFST_FORMAT) -o $@
# first sed is <X> → +X

lexicon.hfst: lexicon.tmp.hfst
	$(AM_V_CP)cp $< $@

# temp hack for some lexc bugs
GENERATED_LEXC_SRCS=generated_files/mul-$(GLANG)-punctuation.lexc \
					generated_files/mul-$(GLANG)-symbols.lexc

# change handling of shared lexical data here:
if HAVE_SHARED_COMMON
.generated/url.tmp.lexc: $(gt_SHARED_common)/src/fst/url.lexc
	$(MAKE) $(GENDIR)
	$(AM_V_CP)cp -f $< $@

generated_files/mul-$(GLANG)-%.lexc: $(gt_SHARED_common)/src/fst/stems/%.lexc
	$(AM_V_at)$(MKDIR_P) generated_files
	$(AM_V_CP)cp -f $< $@
else
# this is "safe" fallback (compiles but you miss everything)
.generated/url.tmp.lexc:
	echo "LEXICON Root" > $@
	echo "< h t t p (s) %: %/ %/ ?*> # ;" >> $@

.generated/mul-$(GLANG)-%.lexc:
	$(MAKE) $(GENDIR)
	echo "! Missing shared common data" > $@
endif
# add other lexical shared data handling here

# Set this to the names of all source xml files, if any
GT_XML_SRCS=

# Define any additional lexc sources here (compiled on their own):
GT_LOCAL_SRCS=

# Define local xfscripts here:
GT_LOCAL_XFSCRIPT_SRCS=

# Define here any additional sources just included in the distro:
GT_DISTRO_SRCS=

### BEGIN: Local processing: ###

### List additional targets in the following variable, for build targets not
### covered by other means. This comes ***in addition to*** what you can do by
### just targeting lexicon.*: lexicon.tmp.*, and is useful if you want to build
### separate fst's that need further treatment in the src/ dir. See the language
### gle/ for an example of how this is used.

GIELLA_LOCAL_TARGETS=

### END: Local processing: ###

####### Other targets: ###########
# Clean: add local clean targets on separate lines, so that the first line can
# easily get updates from the template dir through svn merge.

include $(srcdir)/Makefile.modifications-local.am
include $(srcdir)/Makefile.modifications-phon.am
include $(top_srcdir)/../giella-core/am-shared/src-morphology-dir-include.am

# vim: set ft=automake:
include $(top_srcdir)/../giella-core/am-shared/devtest-include.am
