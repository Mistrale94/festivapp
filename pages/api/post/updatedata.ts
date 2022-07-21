import { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from "@prisma/client"

const prisma = new PrismaClient()

type Data = {

}

export default async function handler(req: NextApiRequest, res: NextApiResponse<Data>){
    if(req.method === "POST"){
        const {id, title, content, image} = req.body
        const post = await prisma.post.update({
            where: {
                id,
            },
            data: {
                title,
                content,
                image,
            },
        })
        res.status(200).json(post) 
    }
}