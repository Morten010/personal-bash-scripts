# define the path to your folder
script_dir=$(dirname $(readlink -f $0))

echo "Creating node with typescript project in: $script_dir"

# init node project
npm init -y

# install dependencies
npm install typescript @types/node ts-node ts-node-dev @types/express --save-dev
npm i express

# Create typescript tsconfig.json
npx tsc --init --rootDir src --outDir build \ --esModuleInterop --resolveJsonModule --lib es6 \ --module commonjs --allowJs true --noImplicitAny true

# remove comments in tsconfig
echo '{
  "compilerOptions": {
    "target": "es5",                          
    "module": "commonjs",                    
    "lib": ["es6"],                     
    "allowJs": true,
    "outDir": "build",                          
    "rootDir": "src",
    "strict": true,         
    "noImplicitAny": true,
    "esModuleInterop": true,
    "resolveJsonModule": true
  }
}' > tsconfig.json

# Create src folder and index file
mkdir src
touch src/index.ts

cd src

echo 'import express from "express";

const port = process.env.PORT || 3001

const app = express();

app.get("/", (req, res) => {
    return res.send("hello world")
});

app.listen(port, () => {
    console.log(`Express server started on port ${port}: http://localhost:${port}`);
});
' > index.ts

cd ..

# find test command in package.json
# using only 'exit 1\' because otherwise it would be placed behind &&
constToFind='exit 1\"'
# add nodemon command (with comma, line break and tab)
replacement=',\n\t\t\"start\": \"nodemon my_file.js\",\n\t\t\"build\": \"tsc .\/src\/index.ts", \n\t\t\"dev\": \"ts-node-dev src\/index.ts\"'

combineReplacement="${constToFind}${replacement}"
# Add start command to package.json
sed -i "s/$constToFind/$combineReplacement/g" package.json