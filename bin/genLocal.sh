echo 'Processing ' $1 ' as ' $1'.raw'

mkdir -p temp
#curl $1 > temp/$1.raw
sed -i 's/x-tm-tenant/Cookie/ig' temp/$1.raw

java -DdebugModels -jar ../modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate \
 -i temp/$1.raw \
 -l csharp \
 -o code/$1 

find code/$1/ -type f -iname *.cs -exec sed -i 's/using io.swagger.client;//g' {} \;
find code/$1/ -type f -iname *.cs -exec sed -i 's/io.swagger/OVS.'$1'/g' {} \;
find code/$1/ -type f -iname *.cs -exec sed -i '1 i\using OVS.Client;' {} \;
mkdir -p output/$1
find code/$1/ -type d -iname Model -exec cp -R {} output/$1 \;
find code/$1/ -type d -iname Api -exec cp -R {} output/$1 \;


echo "!! Output $1 proxy at output/$1"
