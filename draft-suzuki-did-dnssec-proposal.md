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

It is expected that the decentralized design will be widely applied in the future. Still, deploying DID applications requires dependence on existing distributed systems such as Domain Name Systems (DNS). In reality, Methods such as `did:web` that depend on DNS have been proposed. Also, some DID method implementation indirectly depends on DNS, i.e., to reach the service described in the service endpoints.

This proposal discusses `did:dnssec`, which is a bridge to eliminate the gap between the existing Internet world and the new DID world, using DNS Resource Records (DNS RRs) and DNSSEC Resource Records (DNSSEC RRs) as a Verifiable Data Registry (VDR). Using DNS RRs and DNSSEC RRs as a Verifiable Data Registry and applying the signature verification mechanism in DNSSEC as a verification algorithm, we may eliminate some of the dependencies such as DNS resolver dependency in `did:web`.

DNS/DNSSEC RRs as VDRs allow DID applications to access VDRs using the DNS transport mechanisms. Also, since the `did:dnssec` VDR only depends on already deployed DNS servers, there are various advantages over blockchain-based VDR implementations, such as extremely high availability, a wide range of implementation, a long list of experienced operators, rich operational experiences, and so on.

Furthermore, since DNSSEC is designed to work without transport security, successful validation is guaranteed as long as the necessary RR sets are available at the validation stage. The DID document of `did:dnssec` consists of a RR set required to verify subject RR, which is a typed value resolved from Fully Qualified Domain Name (FQDN). The DID document is fully verifiable by following the chain of trust starting from DNS root zone public keys, which are preconfigured as the trust anchor in the verification library.

This proposal describes the list of design decisions needed and presents the necessary actions to design and implement `did:dnssec`.

Note: The author of this proposal demonstrated the use of DNSSEC Resource Records in a similar way in a paper [@PKBADHOC].

# Key Ideas

- Treat DNS/DNSSEC RRs in the DNS zones as a Verifiable Data Registry
  - A VDR with the same control and hierarchical delegation policy as DNS
- DID resolver returns a set of RRs for a given DID as a DID document
  - Resolver collects and returns all of the RRs require to verify the entire chain of trust for an RRset
  - Resolver is also able to provide individual RRset if necessary
  - Since the target of signing, which is the wire-format of RRset, is already in a canonical form, the values in DID document is mere a text converted wire-format values
- Verifier may verify the validity of the given RRs.
 Ultimately, it makes sure of the value of the RR for an FQDN
- By using DNS query over TCP [@RFC7766], the entire process can be
 implemented in a browser

# Actions

- Obtain method-id `dnssec` by registering `did:dnssec` to the DID Spec Registry
- Decides on the patterns of `did:dnssec` DID to express query options
- Develop DNSSEC RRSIG Resource Record Signature Format
- Develop DID document of `did:dnssec`
- Write the specification on DNSSEC RRSIG Resource Record Signature Format
- Write the `did:dnssec` specification
- Implement `did:dnssec` DID document verification library
- Implement `did:dnssec` resolver

# Outcomes

## Specifications

- DNSSEC RRSIG RR Verification Signature Format (`DNSSECRR`)
- `did:dnssec` specification

## Implementations

- `dnsjs` DNS Resource Record handling library
  - Includes DNS resolver stub library using TCP for Web Browser
- `dnssecjs` DNSSEC Resource Record handling library
  - Includes DNSSEC Resource Record signing and verification library
- `did-dnssec-resolver` implementation
  - Includes example application code

# Security Considerations

To be discussed

# IANA Considerations

This document has no IANA actions.

<reference anchor='PKBADHOC' target='https://ci.nii.ac.jp/naid/110008736794'>
    <front>
        <title>Public Key based Authentication Scheme for Ad-hoc Network Nodes Using DNSSEC Resource Records</title>
        <author initials='S.' surname='Suzuki' fullname='Shigeya Suzuki'>
            <organization>Keio University</organization>
        </author>
        <author initials='T.' surname='Ishihara' fullname='Tomohiro Ishihara'>
            <organization>The University of Tokyo</organization>
        </author>
        <author initials='B.' surname='Manning' fullname='Bill Manning'>
            <organization>USC Information Sciences Institute</organization>
        </author>
        <author initials='J.' surname='Murai' fullname='Jun Murai'>
            <organization>Keio University</organization>
        </author>
        <date year='2012'/>
    </front>
</reference>


{backmatter}
