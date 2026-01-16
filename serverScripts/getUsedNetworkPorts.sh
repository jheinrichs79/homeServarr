clear
echo
echo ---------------------------------------------------------------------
echo Here are all the Ports that your machine is using.
echo ---------------------------------------------------------------------
echo Script written by: Jared Heinrichs
echo URL: jaredheinrichs.substack.com
echo
echo
echo "IPv4 Ports Used"
echo "======================="
ss -tulnp4 \
  | awk '
    NR>1 {
      # Extract port
      split($5, a, ":")
      port = a[length(a)]

      # Extract process name from users:(("proc",pid=...,fd=...))
      match($0, /users:\(\("([^"]+)/, m)
      proc = (m[1] != "" ? m[1] : "unknown")

      print port, proc
    }
  ' \
  | sort -n | uniq

echo
echo "IPv6 Ports Used"
echo "======================="
ss -tulnp6 \
  | awk '
    NR>1 {
      split($5, a, ":")
      port = a[length(a)]

      match($0, /users:\(\("([^"]+)/, m)
      proc = (m[1] != "" ? m[1] : "unknown")

      print port, proc
    }
  ' \
  | sort -n | uniq
