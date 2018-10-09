FROM ubuntu:bionic
ENV HOME /root
ENV MINICONDA3 Miniconda3-latest-Linux-x86_64.sh
ENV PATH "$HOME/miniconda3/bin:$PATH"
# You Complete Me (vim plugin) requires build-essential and cmake
RUN apt-get -y update && \
apt-get -y install vim screen curl bzip2 git build-essential cmake && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* && \
curl -O https://repo.continuum.io/miniconda/$MINICONDA3 && \
bash $MINICONDA3 -b -p $HOME/miniconda3 && \
rm $MINICONDA3 && \
$HOME/miniconda3/bin/pip install pylint && \
curl -o $HOME/.vimrc https://raw.githubusercontent.com/michaelperel/vim/master/.vimrc && \
vim +'PlugInstall --sync' +qa >/dev/null 2>&1
CMD bash
