# This file is part of object-drive-ui-baker.
#
#    baker is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    object-drive-ui-baker is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with object-drive-ui-baker .  If not, see <http://www.gnu.org/licenses/>.
FROM fedora:25
MAINTAINER Emory Merryman emory.merryman@deciphernow.com
COPY root /opt/docker/
RUN ["/usr/bin/sh", "/opt/docker/run.sh"]
ENTRYPOINT ["/usr/bin/sh", "/opt/docker/entrypoint.sh"]
CMD []