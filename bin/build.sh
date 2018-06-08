cd ..
../Experiments/apache-maven-3.3.9/bin/mvn clean package

if [ $? -eq 0 ]
then
  cd bin
  exit 0
else
  cd bin
  exit 1
fi
