These keys were collected by Roderick W. Smith in the his rEFInd project 
(http://www.rodsbooks.com/refind/).

This directory contains known public keys for Linux distributions and from
other parties that sign boot loaders and kernels that should be verifiable
by shim or UEFI firmware.

Files come with three extensions. A filename ending in .crt is a
certificate file that can be used by sbverify to verify the authenticity of
a key, as in:

$ sbverify --cert keys/refind.crt refind/refind_x64.efi

The .cer and .der filename extensions are equivalent, and are public key
files similar to .crt files, but in a different form. The MokManager
utility expects its input public keys in this form, so these are the files
you would use to add a key to the MOK list maintained by MokManager and
used by shim.
Some (not all) UEFI firmware can load these keys within the key manupulation 
section of setup utility. 

All Linux keys are self-signed - they can be uploaded in MOK (for Shim) or
in to UEFI db keys list.

The files in this directory are, in alphabetical order:

- altlinux.cer -- The public key for ALT Linux (http://www.altlinux.com).

- canonical-uefi-ca.crt & canonical-uefi-ca.der -- Canonical's public key,
  matched to the one used to sign Ubuntu boot loaders and kernels.

- fedora-ca.cer & fedora-ca.crt -- Fedora's public key, matched to the one
  used used to sign Fedora 18's version of shim and Fedora 18's kernels.

- microsoft-kekca-public.der -- Microsoft's key exchange key (KEK), which
  is present on most UEFI systems with Secure Boot. The purpose of
  Microsoft's KEK is to enable Microsoft tools to update Secure Boot
  variables. 

- microsoft-pca-public.der -- A Microsoft public key, matched to the one
  used to sign Microsoft's own boot loader. You might include this key in
  your MOK list or in UEFI db list if you replace the keys that came with 
  your computer with your own key but still want to boot Windows. 
  There's no reason to add it to your MOK list or in UEFI db list if your
  computer came this key pre-installed and you did not replace the default
  keys.

- microsoft-uefica-public.der -- A Microsoft public key, matched to the one
  Microsoft uses to sign third-party applications and drivers. If you
  remove your default keys, adding this one to UEFI db list or to your MOK 
  list will enable  you to launch third-party boot loaders and other tools 
  signed by Microsoft. There's no reason to add it to MOK/db list if your 
  computer came this key pre-installed and you did not replace the default
  keys.

- openSUSE-UEFI-CA-Certificate.cer & openSUSE-UEFI-CA-Certificate.crt --
  Public keys matched to the ones used to sign OpenSUSE 12.3.

- refind.cer & refind.crt -- My own (Roderick W. Smith's) public key,
  matched to the one used to sign refind_x64.efi and the 64-bit rEFInd
  drivers.

- SLES-UEFI-CA-Certificate.cer & SLES-UEFI-CA-Certificate.crt -- The
  Public key for SUSE Linux Enterprise Server.
