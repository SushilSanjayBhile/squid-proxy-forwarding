# squid-proxy-forwarding
Port forwarding using Squid

For port forwarding you need to setup this pod and use ip address of the pod in proxy setting.

## URL to use:- http://<ip_address_of_the_pod>:**3128** 

## 3 parts of url are composed of following things:-

1) **http://** is also must in url, for proxy setting to know whether server is http/https
2) ip_address of pod
3) **3128** is default squid proxy service port
