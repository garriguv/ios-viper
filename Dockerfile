FROM swift

WORKDIR /usr/src/ios-viper
COPY Package.swift /usr/src/ios-viper
COPY Sources/ /usr/src/ios-viper/Sources
COPY Templates/ /usr/src/ios-viper/Templates

RUN swift build --configuration release

ENTRYPOINT ["/usr/src/ios-viper/.build/release/ios-viper"]
