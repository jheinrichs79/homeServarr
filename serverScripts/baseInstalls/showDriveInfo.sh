bash -c 'sudo lshw -class disk | awk "
  /logical name/ {name=\"  \" \$0; valid=1}
  /size/ {if (valid) {print name; print \"  \" \$0; print \"\"; valid=0}} 
" | grep -v configuration'


# EXAMPLE OUTPUT
# =========================================
#    logical name: /dev/sda
#    size: 10TiB (12TB)
#
#    logical name: /dev/nvme0n1
#    size: 238GiB (256GB)
