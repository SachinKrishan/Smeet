const express = require('express')
const User = require('../models/user.models.js')
const router = express.Router()


router.post('/signup', async (req, res) => {
    try {
        const existingUser = await User.findOne({ email: req.body.email });
        
        if (existingUser) {
            return res.json({ message: 'Email is not available' });
        }

        const newUser = new User({
            email: req.body.email,
            password: req.body.password
        });

        await newUser.save();
        res.json(newUser);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

router.post('/signin', async (req,res)=>{

    const validUser = await User.findOne({ email:req.body.email,password:req.body.password });
        
        if (validUser) {
            console.log(validUser)
            return res.json({ message: 'user verified', user: validUser });
        }
        else{
            console.log(validUser)
            return res.json({ message: 'user not found or invalid password', user: validUser });
        }

    // User.findOne({email:req.body.email,password:req.body.password},(err,user)=>{
    //     if(err){
    //         console.log(err)
    //         res.json(err)
    //     }else{
    //         res.json(user)   
    //     }
    // })
})
module.exports = router