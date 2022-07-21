import { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from "@prisma/client"

const prisma = new PrismaClient()

type Data = {

}

export default async function handler(req: NextApiRequest, res: NextApiResponse<Data>){
    if(req.method === 'POST'){
        const {title, content, image, user} = req.body
        const post = await prisma.post.create({
            data: {
                title,
                content,
                image,
                user,
            }
        })
        res.status(200).json(post)
    }
}