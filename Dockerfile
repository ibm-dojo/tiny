FROM scratch
MAINTAINER Morgan Bauer <mbauer@us.ibm.com>
ADD hello hello
ENTRYPOINT ["/hello"]
