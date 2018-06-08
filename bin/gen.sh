echo 'Getting ' $1 ' and processing as ' $2
mkdir -p temp
curl $1 > temp/$2.raw
sed -i 's/x-tm-tenant/Cookie/ig' temp/$2.raw

java -DdebugModels -jar ../modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate \
 -i temp/$2.raw \
 -l csharp \
 -o code/$2 

find code/$2/ -type f -iname *.cs -exec sed -i 's/using io.swagger.client;//g' {} \;
find code/$2/ -type f -iname *.cs -exec sed -i 's/io.swagger/OVS.'$2'/g' {} \;
find code/$2/ -type f -iname *.cs -exec sed -i '1 i\using OVS.Client;' {} \;
mkdir -p output/$2
find code/$2/ -type d -iname Model -exec cp -R {} output/$2 \;
find code/$2/ -type d -iname Api -exec cp -R {} output/$2 \;


echo "!! Output $1 proxy at output/$2"
