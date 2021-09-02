%%%
title = "Proposal on the Design and Implementation of a DID method over DNSSEC (did:dnssec)"
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

In this document, we proposes a new DID method, `did:dnssec`, which using DNSSEC Resources Records as the basis for its Verifiable Data Registry. This document also describe the expected activities relates the design and implementation of the DID method.

{mainmatter}

# Introduction

Decentralized Identifier (DID) is a technology for implementing verifiable namespaces in a decentralized manner. It can be implemented in a way that eliminates dependence on other entities, also able to materialize a Self-Sovereign Identity (SSI). By applying blockchain technology, fully decentralized identity is implementable. Because of its  decentralization focusing design, there is a clear distinction from the centralized or hierarchical control delegation mechanisms often used in the current Internet.

While it is expected that the decentralized design will be widely applied in the future, deploying DID applications often requires dependence on existing distributed systems such as Domain Name Systems (DNS). For example, Methods such as `did:web` that depend on DNS have been proposed. Also, some DID method implementation indirectly depends on DNS, i.e., to reach the service described in DID documents as service endpoints.

The new `did:dnssec` method uses DNS Resource Records (DNS RRs) and DNSSEC Resource Records (DNSSEC RRs) as a Verifiable Data Registry (VDR) to eliminate the gap between the existing Internet world and the new DID world (DNSSEC VDR hereafter). Using DNS RRs and DNSSEC RRs as a VDR and applying the signature verification mechanism in DNSSEC to establish the chain of trust of a Fully Qualified Domain Name (FQDN) through multiple DNS zones. By using locally verified FQDN to RR mapping, we can eliminate external entity dependencies in DID documents such as DNS resolver dependency in `did:web`.

Access to the DNSSEC VDR is possible via currently available DNS transport mechanisms. Nowadays, since browsers can reach DNS Servers via TCP, whole process including fetching RRs and verifying the RRset may complete in a browser. Also, since the DNSSEC VDR only depends on already deployed DNS servers, there are numerous advantages over blockchain-based VDR implementations, such as extremely high availability, a wide range of implementation, a long list of experienced operators, rich operational experiences, and so on.

Furthermore, since DNSSEC is designed to work without transport security, successful validation is guaranteed as long as the necessary RR sets are available at the validation stage. It is possible to mix set of RRs retrieved from multiple serves for a validation process. The DID document of `did:dnssec` consists of a RR set required to verify subject RR, which is a typed value resolved from FQDN. The DID document is fully verifiable by following the chain of trust starting from DNS root zone public keys, which are statically preconfigured as the trust anchor in the verification library, which is common among typical DNS resolver implementations.

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

# Deliverables

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
