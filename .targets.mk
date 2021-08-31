TARGETS_DRAFTS := draft-suzuki-did-dnssec-proposal 
TARGETS_TAGS := 
draft-suzuki-did-dnssec-proposal-00.md: draft-suzuki-did-dnssec-proposal.md
	sed -e 's/draft-suzuki-did-dnssec-proposal-latest/draft-suzuki-did-dnssec-proposal-00/g' $< >$@
