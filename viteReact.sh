# define the path to your folder
script_dir=$(dirname $(readlink -f $0))

echo "Creating a vite project in: $script_dir"

# create vite app
npm create vite@latest . -- --template react-swc-ts

# install all depencies from init
npm i

# install new depencies
npm install react-router-dom sass react-icons axios react-query

# app template
app="import { BrowserRouter, Route, Routes } from 'react-router-dom'
import './App.css'
import Homepage from './pages/Homepage'

function App() {

  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route path='/' element={<Homepage />}/> 
        </Routes>
      </BrowserRouter>
    </>
  )
}

export default App"

# cd into src folder
cd src

# set app template
echo "$app" > App.tsx

# make pages folder
mkdir pages

# cd into pages and make homepage
cd pages
touch Homepage.tsx

# homepageTemplate
homepage="import { FC } from 'react'

interface HomepageProps {
  
}

const Homepage: FC<HomepageProps> = ({}) => {
  return (
    <div>
      Homepage
    </div>
  )
}

export default Homepage"

# insert homepage template into homepage.tsx
echo "$homepage" > Homepage.tsx
