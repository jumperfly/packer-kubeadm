#!/bin/bash
packer build -except vagrant-cloud -var build_number=0 -var skip_shrink=1 .
