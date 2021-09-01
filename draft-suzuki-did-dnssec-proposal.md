%%%
title = "Proposal on a DID method over DNSSEC (did:dnssec)"
abbrev = "did-dnssec-proposal"
docName = "draft-suzuki-did-dnssec-proposal-latest"
category = "info"
ipr = "none"
workgroup="proposal"
keyword = ["did", "dns", "dnssec", "verifiable data registry"]

[seriesInfo]
name = "Internet-Draft"
value = "draft-suzuki-did-dnssec-proposal"
status = "standard"

[pi]
toc = "yes"

[[author]]
initials = "S."
surname = "Suzuki"
fullname = "Shigeya Suzuki"
organization = "Graduate School of Media and Governance, Keio University"
  [author.address]
   email = "shigeya@wide.ad.jp"

%%%

.# Abstract

This document proposes a new DID method, `did:dnssec`, which using DNSSEC Resources Records as the basis for its Verifiable Data Registry.

{mainmatter}

# Introduction

Decentralized Identifier (DID) is a technology for implementing verifiable namespaces in a decentralized manner. It can be implemented in a way that eliminates dependence on others, also able to realize a Self-Sovereign Identity (SSI). Decentralization can be achieved by relying on blockchain technology. Because of its complete decentralization, there is a clear distinction from the centralized or hierarchical control delegation mechanisms often used in the current Internet.

It is expected that the decentralized design will be widely applied in the future. Still, deploying applications using DID requires dependence on existing distributed systems such as Domain Name Systems (DNS). For this reason, methods such as `did:web` that depend on DNS have been proposed. Also, some DID method implementation indirectly depends on DNS, i.e., to reach the service described in the service endpoints.

`did:dnssec` is proposed as a technique to bridge the gap between the existing Internet world and the new DID world, using DNS Resource Records (DNS RRs) and DNSSEC Resource Records (DNSSEC RRs) as a Verifiable Data Registry (VDR). Using DNS RRs and DNSSEC RRs as a Verifiable Data Registry and applying the signature verification mechanism in DNSSEC as a verification algorithm, we may eliminate some of the dependencies such as DNS resolver dependency in `did:web`.

Using DNS/DNSSEC RRs as VDRs means that the VDRs can be accessed using the DNS transport mechanisms. Since the `did:dnssec` VDR only depends on already deployed DNS servers, there are various advantages over blockchain-based VDR implementations, such as extremely high availability, a wide range of implementation, a long list of experienced operators, operational experiences, and so on.

Furthermore, since DNSSEC is designed to work without transport security, successful validation is guaranteed as long as the necessary RR sets are available at the validation stage. In `did:dnssec`, the RR set required for verification is designed to be a DID document. Therefore, if we can obtain the DID document corresponding to the `did:dnssec` DID, we can verify it only with and starting from the trust anchor of the DNS root zone.

This proposal describes the list of design decisions needed and presents the necessary actions to design and implement `did:dnssec`.

# Key Ideas

- Treat DNS/DNSSEC RRs as a Verifiable Data Registry
  - A VDR with the same control and hierarchical delegation policy with DNS
- DID resolver returns set of RRs for a given DID as a DID document
  - Resolver collects and returns all of RRs require to verify entire chain of trust for a RRset
  - Resolver also able to provide individual RRset if necessary
- Verifier may verify the legitimacy of the given RRs.
  Ultimately, makes sure of the value of the RR for the FQDN
- By using DNS query over TCP [@RFC7766], the entire process can be
  implemented in a browser.

# Actions

- Register to the DID Spec Registry
- Decides on DID to DID document query pattern
- Design DNSSEC Signature Verification Algorithm
- Write a spec on DNSSEC Signature Verification Algorithm
- Write `did:dnssec` specification
- Implement `did:dnssec` resolver
- Discuss based on DNSSEC RR handling, or provides references to related DNS/DNSSEC RFCs.

# Outcomes

## Specifications

- `did-dnssec` specification

## Implementations

- `dnsjs` Resource Record handling library
  - Includes DNS resolver stub library using TCP for Web Browser
- `dnssecjs` DNSSEC Resource Record handling library
  - Includes DNSSEC RR signing and verification library
- `did-dnssec-resolver` implementation
  - Includes example application code

# Security Considerations

- Requirements for supporting algorithms
- Application interface for verification

# IANA Considerations

This document has no IANA actions.

{backmatter}
