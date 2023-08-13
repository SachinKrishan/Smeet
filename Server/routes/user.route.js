const express = require('express')
const User = require('../models/user.models.js')
const router = express.Router()


router.post('/signup', async (req, res) => {
    console.log(req.body);
    try {
        const existingUser = await User.findOne({ email: req.body.email });
        
        if (existingUser) {
            return res.json({ message: 'Email is not available' });
        }

        const newUser = new User({
            fullName: req.body.name,
            email: req.body.email,
            linkedin: req.body.email,
            availability: req.body.availability,
            password: req.body.password
        });

        console.log(newUser);
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
})

router.get('/search', async (req, res) => {
    const searchTerm = req.query.q; // Get the search term from query parameter
    try {
        console.log("api called with ", searchTerm)
        const employees = await User.find({
        name: { $regex: searchTerm, $options: 'i' }, // Case-insensitive search
      }, { name : 1, email : 1 });
      res.json(employees);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
  });


module.exports = router