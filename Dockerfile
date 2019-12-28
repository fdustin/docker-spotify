#########################################################################
# Container: syncomm/spotify                                            #
# Version: 0.5.0                                                        #
#                                                                       #
# Description:                                                          #
# A container for running firefox and pipelight to access netflix       #
#                                                                       #
# Copyright (C) 2014, 2015 Gregory S. Hayes <syncomm@gmail.com>         #
#                                                                       #
# This program is free software; you can redistribute it and/or modify  #
# it under the terms of the GNU General Public License as published by  #
# the Free Software Foundation; either version 2 of the License, or     #
# (at your option) any later version.                                   #
#                                                                       #
# This program is distributed in the hope that it will be useful,       #
# but WITHOUT ANY WARRANTY; without even the implied warranty of        #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
# GNU General Public License for more details.                          #
#                                                                       #
# You should have received a copy of the GNU General Public License     #
# along with this program; if not, write to the                         #
# Free Software Foundation, Inc.,                                       #
# 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             #
#                                                                       #
# modified by Timo Kramer <kontak@timokramer.de>                        #
#                                                                       #
#########################################################################

FROM ubuntu 

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN DEBIAN_FRONTEND=noninteractive curl -sS https://download.spotify.com/debian/pubkey.gpg |  apt-key add - 
RUN DEBIAN_FRONTEND=noninteractive echo "deb http://repository.spotify.com stable non-free" |  tee /etc/apt/sources.list.d/spotify.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install spotify-client
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libpangoxft-1.0-0 libpangox-1.0-0 xauth pulseaudio

ADD start-spotify.sh /usr/bin/start-spotify.sh
RUN chmod +x /usr/bin/start-spotify.sh

RUN useradd -d /home/spotify -p "!" -m -g audio -c "Docker-Spotify" spotify
USER spotify
ENV HOME /home/spotify

VOLUME /home/spotify/

ENTRYPOINT "/usr/bin/start-spotify.sh"
