rm ssh_host_*
ssh-keygen -t ed25519 -f ssh_host_ed25519_key -N ''
ssh-keygen -t rsa -b 4096 -f ssh_host_rsa_key -N ''

echo ----------------------------------------------------------------
echo
awk '{printf "%s\\n",$0} END {print ""}' < ssh_host_ed25519_key
echo ----------------------------------------------------------------
echo
awk '{printf "%s\\n",$0} END {print ""}' < ssh_host_rsa_key
echo ----------------------------------------------------------------

rm ssh_host_*
