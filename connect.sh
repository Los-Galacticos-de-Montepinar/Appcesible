#!/bin/bash
#
# 	Es necesario modificar los permisos de acceso.pem
#
#	Windows:
#	You locate the file in Windows Explorer, right-click on it then select "Properties". 
#	Navigate to the "Security" tab and click "Advanced".
#	Change the owner to you, disable inheritance and delete all permissions. 
#	Then grant yourself "Full control" and save the permissions. 
#	Now SSH won't complain about file permission too open anymore.
#
#	Linux:
# 	$ chmod 400 acceso.pem

#	Conexion
ssh -i "acceso.pem" ubuntu@ec2-52-47-99-235.eu-west-3.compute.amazonaws.com
