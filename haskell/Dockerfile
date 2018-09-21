FROM haskell:8

WORKDIR /opt/server

RUN cabal update

COPY ./microservice-factorial.cabal /opt/server/microservice-factorial.cabal
RUN cabal install --only-dependencies -j4

COPY . /opt/server
RUN cabal install

CMD ["microservice-factorial"]
