FROM ubuntu:22.04

# Enable 32-bit architecture and install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y wine64 wine32 unzip curl ca-certificates winbind

# Create and switch to non-root user
RUN useradd -m steam
USER steam
WORKDIR /home/steam

# Copy SteamCMD for Windows
COPY steamcmd.zip .
RUN unzip steamcmd.zip

# Suppress WINE output unless there's an actual error
ENV WINEDEBUG=-all

# Entry point with overrideminos baked in
ENTRYPOINT ["wine", "steamcmd.exe", "-overrideminos"]
