# Enough fresh TeXLive and enough old Emacs for org-tangle in Jammy
FROM ubuntu:jammy
LABEL name="Pāli-English Recitations build image"
LABEL version="0.3"

# hadolint ignore=DL3008
RUN \
  apt-get update && \
  apt-get install --no-install-recommends --yes \
    ca-certificates \
    git \
    locales \
    make \
    zip \
    && \
  apt-get clean && \
  echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  locale-gen && \
  rm -rf /var/lib/apt/lists/*

ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"

ARG DEBIAN_FRONTEND=noninteractive
# hadolint ignore=DL3008
RUN \
  apt-get update && \
  apt-get install --no-install-recommends --yes \
    calibre \
    emacs-nox \
    epubcheck \
    rename \
    && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3008
RUN \
  apt-get update && \
  apt-get install --no-install-recommends --yes \
    texlive \
    texlive-extra-utils \
    texlive-fonts-extra \
    texlive-latex-extra \
    tipa \
    && \
  luaotfload-tool --update && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ARG doomemacs_repo="https://github.com/doomemacs/doomemacs"
ARG doomemacs_ref="d5ccac5d71c819035fa251f01d023b3f94b4fba4"
ENV PATH="$PATH:/root/.emacs.d/bin/"
WORKDIR /root/.emacs.d/
# hadolint ignore=DL3008
RUN \
  git init && \
  git remote add origin "$doomemacs_repo" && \
  git fetch --depth 1 origin "$doomemacs_ref" && \
  git checkout FETCH_HEAD && \
  org-tangle

WORKDIR /root/
