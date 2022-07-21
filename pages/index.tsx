import type { NextPage } from 'next'
import React, { useState, useEffect } from "react"  

const Home: NextPage = () => {
    const [data, setData] = useState([])
    const [editMode, setEditMode] = useState(false)
    const [inputedData, setInputedData] = useState({
        id: "",
        title: "",
        content: "",
        image: "",
    })

    const fetchData = async () => {
        const response = await fetch(`/api/post/getdata`)
        const json = await response.json()
        setData(json)
    }



    const handleCreateData = async(e: React.FormEvent) => {
        e.preventDefault()
        if (editMode){
            handleUpdateData()
        } else{
            const response = await fetch(`/api/post/createdata`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    title: inputedData.title,
                    content: inputedData.content,
                    image: inputedData.image,
                })
            })
            const json = await response.json()
            console.log(json)
            setInputedData({ id: "", title: "", content: "", image: "" })
            fetchData()
        }
    }
    
    const handleDeleteData = async (id: string) => {
        console.log(id)
        const response = await fetch(`/api/post/deletedata`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ id }),
        })
        const json = await response.json()
        console.log(json)
        fetchData()
    }

    const handleEditData = async(id: string, title: string, content: string, image: string) => {
        setInputedData({id, title, content, image})
        setEditMode(true)
    }

    const handleUpdateData = async () => {
        const response = await fetch(`/api/post/updatedata`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                id: inputedData.id,
                title: inputedData.title,
                content: inputedData.content,
                image: inputedData.image,
            })
        })
        const json = await response.json()
        console.log(json)
        setInputedData({ id: "", title: "", content: "", image: "" })
        setEditMode(false)
        fetchData()
    }

    useEffect(() => {
        fetchData()
    }, [])

    return (
        <div>
            <h1>Next Crud</h1>
            <div>
                <form onSubmit={handleCreateData}>
                    <input
                        value={inputedData.title || ""}
                        type="text"
                        placeholder="Titre"
                        onChange={(e)=> setInputedData({... inputedData, title: e.target.value})}
                    />
                    <input
                        value={inputedData.content || ""}
                        type="text"
                        placeholder="Description"
                        onChange={(e)=> setInputedData({... inputedData, content: e.target.value})}
                    />
                    <input
                        value={inputedData.image || ""}
                        type="text"
                        placeholder="image"
                        onChange={(e)=> setInputedData({... inputedData, image: e.target.value})}
                    />
                    <button type="submit">Envoyer</button>
                </form>
            </div>
            <div>
                {data.map(({id,title,content,image}) => {
                    return(
                        <div key={id}>
                            <h3>{title}</h3>
                            <p>{content}</p>
                            <p>{image}</p>
                            <button onClick={() => handleDeleteData(id)}>Supprimer</button>
                            <button onClick={() => handleEditData(id, title, content, image)}>Modifier</button>
                        </div>
                    ) 
                })}
            </div>
        </div>
    )
}

export default Home