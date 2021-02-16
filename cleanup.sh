yum clean all
rm -rf /var/cache/yum

if [[ -z "$PACKER_SKIP_SHRINK_DISK" ]]; then
  dd if=/dev/zero of=/boot/ZERO bs=1M || echo "ignoring expected dd error"
  rm /boot/ZERO
  dd if=/dev/zero of=/ZERO bs=1M  || echo "ignoring expected dd error"
  rm /ZERO
  sync
fi

export HISTSIZE=0
rm -f /root/.wget-hsts
