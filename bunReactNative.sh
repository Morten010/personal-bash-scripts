bunx create-expo-app -e with-router-tailwind .

bun add clsx tailwind-merge class-variance-authority

cd src

mkdir utils

cd utils

touch "index.ts"

echo 'import { ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export const cn = (...inputs: ClassValue[]) => {
  return twMerge(clsx(inputs))
}' > index.ts

# create components

cd ..
mkdir components
cd ./components

touch "Button.tsx"
touch "Input.tsx"
touch "Heading.tsx"

echo 'import { cn } from "@/utils"
import { cva, VariantProps } from "class-variance-authority"
import { FC } from "react"
import { Pressable, Text, TouchableHighlight, TouchableOpacity } from "react-native"

const buttonVariants = cva(
    "rounded-xl bg-blue-500", 
    {
      variants: {
        rounded: {
          xl: "rounded-2xl",
          lg: "rounded-lg",
          md: "rounded-md",
          sm: "rounded",
          default: "rounded-xl"
        }
      },
      defaultVariants: {
        rounded: "default"
      },
    }
  )
  
  type buttonType =  React.ComponentProps<typeof TouchableHighlight>
  
  interface ButtonProps extends buttonType, VariantProps<typeof buttonVariants> {
    text: string
    size?: "xl" | "md" | "sm",
    textPosition?: "start" | "center" | "end"
    color?: "primary" | "danger" | "success"
  }
  

const Button: FC<ButtonProps> = ({className, size, text, rounded, color, textPosition, ...props}) => {
  let buttonSize = ""
  let textSize = ""
  let textColor = ""
  let ButtonColor = ""
  let position = ""

  switch (size) {
    case "xl":
      buttonSize = "px-5 py-3"
      textSize = "text-xl"
      break;
    case "md":
      buttonSize = "px-4 py-3"
      textSize = "text-lg"
      break
    case "sm":
      buttonSize = "px-4 py-3"
      textSize = "text-lg"
      break
    default:
      buttonSize = "px-5 py-3"
      textSize = "text-xl"
      break;
  }

  switch(color){
    case "danger": 
      textColor = "text-white"
      ButtonColor = "bg-red-600"
      break
    case "primary": 
      textColor = "text-white"
      ButtonColor = "bg-blue-600"
      break
    case "success": 
        textColor = "text-white"
        ButtonColor = "bg-green-700"
      break
    default:
      textColor = "text-white"
      ButtonColor = "bg-blue-500"
      break
  }

  switch(textPosition){
    case "center":
      position = "text-center"
      break
    case "end":
      position = "text-left"
      break
    case "end":
      position = "text-right"
      break
    default:
      position = "text-center"
      break
  }


  return (
    <TouchableOpacity
    className={cn(buttonVariants({ className, rounded}), buttonSize, ButtonColor)}
    {...props}>
      <Text
      className={cn("font-semibold", textSize, textColor, position)}
      >
        {text}
      </Text>
    </TouchableOpacity>
  )
}

export default Button' > Button.tsx

echo 'import { cn } from "@/utils"
import { cva, VariantProps } from "class-variance-authority"
import { FC } from "react"
import { Text } from "react-native"

const headingVariants = cva(
    "text-6xl font-semibold",
    {
        variants: {
            heading: {
                xl: "text-6xl",
                lg: "text-5xl",
                md: "text-4xl",
                default: "text-2xl" 
            },
            position: {
                center: "text-center",
                end: "text-right",
                start: "text-left"
            }
        }
    }
)

type TextType =  React.ComponentProps<typeof Text>

interface HeadingProps extends TextType, VariantProps<typeof headingVariants> {
  
}

const Heading: FC<HeadingProps> = ({ className, heading, position: position, ...props }) => {
  return (
    <Text
    role="heading"
    className={cn(headingVariants({ heading, position: position,  className }))}
    {...props}
    />
  )
}

export default Heading' > Heading.tsx

echo 'import { cn } from '@/utils'
import { cva } from 'class-variance-authority'
import { FC } from 'react'
import { TextInput, View } from 'react-native'

const inputVariants = cva(
  "text-xl px-4 py-3 border border-2 rounded-xl border-gray-500"
)

type TextInputType =  React.ComponentProps<typeof TextInput>

interface InputProps extends TextInputType {
}

const Input: FC<InputProps> = ({className, ...props}) => {
  return (
    <TextInput 
    className={cn(inputVariants({ className}))}
    {...props}
    />
  )
}

export default Input' > Input.tsx