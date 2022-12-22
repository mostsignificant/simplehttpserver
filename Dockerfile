########################################################################################################################
# simplehttpserver build stage
########################################################################################################################

FROM debian:bullseye-slim AS build

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential=12.9 \
    cmake=3.18.4-2+deb11u1 \
    libboost-all-dev=1.74.0.3

WORKDIR /simplehttpserver

COPY src/ ./src/
COPY CMakeLists.txt .

RUN mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    cmake --build . --parallel 8

########################################################################################################################
# simplehttpserver image
########################################################################################################################

FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libboost-program-options1.74.0

RUN useradd -ms /bin/bash shs
USER shs

COPY --chown=shs:shs --from=build \
    ./simplehttpserver/build/src/simplehttpserver \
    ./app/

ENTRYPOINT [ "./app/simplehttpserver" ]
