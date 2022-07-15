flutter build web --web-renderer html --release --base-href "/car/"
scp -r ./build/web/* root@nightmare.fun:/home/nightmare/apache-tomcat/webapps/car/
