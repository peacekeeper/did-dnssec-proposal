%%%
title = "Proposal on the Design and Implementation of a DID method over DNSSEC (did:dnssec)"
abbrev = "did-dnssec-proposal"
docName = "draft-suzuki-did-dnssec-proposal-latest"
category = "info"
ipr = "none"
workgroup="Proposal"
keyword = ["did", "dns", "dnssec", "verifiable data registry"]
submissionType="independent"

[seriesInfo]
name = "Internet-Draft"
value = "draft-suzuki-did-dnssec-proposal"
status = "informational"

[pi]
toc = "yes"

[[author]]
initials = "S."
surname = "Suzuki"
fullname = "Shigeya Suzuki"
organization = "Keio University"
  [author.address]
   email = "shigeya@wide.ad.jp"

%%%

.# Abstract

We propose a new DID method, `did:dnssec`, which uses DNSSEC Resources Records as the basis for its Verifiable Data Registry. This document describes background information, key ideas, and planned activities related to the DID method's design and implementation.

.# Copyright Notice
Copyright (c) 2021 Keio University and the persons identified as the document authors. All rights reserved.

{mainmatter}

# Introduction

Decentralized Identifier (DID)[@DID-CORE] is a technology for implementing verifiable identifiers in a decentralized manner. It can be implemented in a way that eliminates dependence on other entities, also able to materialize a Self-Sovereign Identity (SSI). By applying blockchain technology, a fully decentralized identity is possible. Because of its decentralization focusing design, there is a clear distinction from the centralized or hierarchical control delegation mechanisms often used in the current Internet.

While we anticipate broad deployments of applications using DID in the future, deployment often requires dependence on existing distributed systems such as Domain Name Systems (DNS). For example, `did:web` [@DID-WEB] depends on DNS. Also, some DID method implementation indirectly depends on DNS, i.e., to reach the service described in DID documents as service endpoints.

The new `did:dnssec` method uses DNS Resource Records (DNS RRs)[@RFC1035] and DNSSEC Resource Records (DNSSEC RRs)[@RFC4034] as a Verifiable Data Registry (VDR) to eliminate the gap between the existing Internet world and the new DID world. Using DNS RRs and DNSSEC RRs as a VDR (DNSSEC VDR hereafter) and applying the signature verification mechanism in DNSSEC enable establishing the chain of trust of a Fully Qualified Domain Name (FQDN) through multiple DNS zones. Using locally verifiable FQDN to RR mapping can eliminate external entity dependencies in DID documents such as DNS resolver dependency in `did:web`, if the cost of local validation is acceptable.

Access to DNSSEC VDRs is possible via the currently available DNS transport mechanisms. Since browsers can now access DNS servers via TCP[@RFC7766], the whole process, including RR retrieval and RR set validation, can be completed within the browser. Also, since the DNSSEC VDR only depends on already deployed DNS servers, there are numerous advantages over blockchain-based VDR implementations, such as: extremely high availability, a wide range of implementation, a long list of experienced operators, rich operational experiences, and so on.

Furthermore, since DNSSEC is designed to work without transport security, successful validation is guaranteed as long as the necessary RR sets are available at the validation stage. It is possible to mix sets of RRs retrieved from multiple servers for a validation process. The DID document of `did:dnssec` consists of the subject FQDN and a set of RRsets required to verify the subject RR. The DID document is fully verifiable by following the chain of trust starting from the DNSSEC trust anchor (public keys which bound to the root zone key signing keys), which are statically preconfigured as the trust anchor in the verification library, which is common among typical DNS resolver implementations.

This proposal describes the list of design decisions needed and presents the necessary actions to design and implement `did:dnssec`.

Note: The author of this proposal demonstrated the use of DNSSEC Resource Records similarly in a paper [@PKB-ADHOC].

# Key Ideas

- Treat DNS/DNSSEC RRs in the DNS zones as a Verifiable Data Registry
  - A VDR with the same control and hierarchical delegation policy as DNS
- DID resolver returns a set of RRs for a given DID as a DID document
  - Resolver collects and returns all of the RRs require to verify the entire chain of trust for an RRset
  - Resolver is also able to provide individual RRset if necessary
  - Since the target of signing, which is the wire-format of RRset, is already in a canonical form, the values in DID document is mere a text converted wire-format values
- Verifier can verify the validity of the subject RRset referred by the FQDN
- Using DNS query over TCP [@RFC7766] makes the entire process possible to complete within a browser

# Actions

- Obtain method-id `dnssec` by registering `did:dnssec` to the DID Spec Registry
- Decides on the patterns of `did:dnssec` DID to express query options
- Develop DNSSEC RRSIG Resource Record Signature Format
- Develop DID document format of `did:dnssec`
- Write the specification on DNSSEC RRSIG Resource Record Signature Format
- Write the `did:dnssec` specification
- Implement `did:dnssec` DID document verification library
- Implement `did:dnssec` resolver

Note: the author of this proposal has implemented the part of library code in C++, which is the part of the iOS application code prepared for the experiment of [@PKB-ADHOC]. The author is currently actively translating and refactoring the code as libraries in TypeScript language.

# Deliverables

## Specifications

- DNSSEC RRSIG RR Verification Signature Format (`DNSSECRR`)
- `did:dnssec` specification

## Implementations

- DNS Resource Record handling library
  - Includes DNS resolver stub library using TCP for Web Browser
- DNSSEC Resource Record handling library
  - Includes DNSSEC Resource Record signing and verification library
- DNSSEC DID Resolver implementation (`did-dnssec-resolver`)
  - Includes example application code

# Security Considerations

To be discussed

# IANA Considerations

This document has no IANA actions.

<reference anchor='PKB-ADHOC' target='https://ci.nii.ac.jp/naid/110008736794'>
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

<reference anchor='DID-CORE' target='https://www.w3.org/TR/2021/PR-did-core-20210803/'>
    <front>
        <title>Decentralized Identifiers (DIDs) v1.0 - Core architecture, data model, and representations (W3C Proposed Recommendation)</title>
        <author initials='M.' surname='Sporny' fullname='Manu Sporny' role='editor'>
            <organization>Digital Bazaar</organization>
        </author>
        <author initials='A.' surname='Guy' fullname='Amy Guy' role='editor'>
            <organization>Digital Bazaar</organization>
        </author>
        <author initials='M.' surname='Sabadello' fullname='Markus Sabadello' role='editor'>
            <organization>Danube Tech</organization>
        </author>
        <author initials='D.' surname='Reed' fullname='Drummond Reed' role='editor'>
            <organization>Evernym</organization>
        </author>
        <author initials='M.' surname='Sporny' fullname='Manu Sporny'>
          <organization>Digital Bazaar</organization>
        </author>
        <author initials='D.' surname='Longley' fullname='Dave Longley'>
          <organization>Digital Bazaar</organization>
        </author>
        <author initials='M.' surname='Sabadello' fullname='Markus Sabadello'>
          <organization>Danube Tech</organization>
        </author>
        <author initials='D.' surname='Reed' fullname='Drummond Reed'>
          <organization>Evernym</organization>
        </author>
        <author initials='O.' surname='Steele' fullname='Orie Steele'>
          <organization>Transmute</organization>
        </author>
        <author initials='C.' surname='Allen' fullname='Christopher Allen'>
          <organization>Blockchain Commons</organization>
        </author>
        <date year='2021' month='8' date='3'/>
    </front>
</reference>

<reference anchor='DID-WEB' target='https://w3c-ccg.github.io/did-method-web/'>
    <front>
        <title>did:web Method Specification - Draft Community Group Report 26 July 2021</title>
        <author initials='M.' surname='Prorock' fullname='Michael Prorock' role='editor'>
            <organization>mesur.io</organization>
        </author>
        <author initials='O.' surname='Steele' fullname='Orie Steele' role='editor'>
          <organization>Transmute</organization>
        </author>
        <author initials='O.' surname='Terbu' fullname='Oliver Terbu' role='editor'>
          <organization>Consensys</organization>
        </author>
        <author initials='C.' surname='Christian' fullname='Christian Gribneau'>
            <organization>DigitOlogy Newswire, Inc.</organization>
        </author>
        <author initials='M.' surname='Prorock' fullname='Michael Prorock'>
            <organization>mesur.io</organization>
        </author>
        <author initials='O.' surname='Steele' fullname='Orie Steele'>
          <organization>Transmute</organization>
        </author>
        <author initials='O.' surname='Terbu' fullname='Oliver Terbu'>
          <organization>Consensys</organization>
        </author>
        <author initials='M.' surname='Mike' fullname='Mike Xu'>
          <organization>Consensys</organization>
        </author>
        <author initials='D.' surname='Dmitri' fullname='Dmitri Zagidulin'>
          <organization>Digital Bazaar</organization>
        </author>
        <date year='2021' month='6' date='26'/>
    </front>
</reference>
{backmatter}
