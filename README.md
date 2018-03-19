# The Pivot

Le Pivot is a brownfield project that began as a single-tenant e-commerce web application. The goal of the project was to convert the existing application into a multi-tenant app. Additional features include role-based authorization, new store approvals, streamlined check-out process, billing with Stripe, storing credit cards for users, providing business insights to administrators and more. This project was completed over 2 weeks by 3 students at Turing School of Software Design & Development. 

## Deployment

This project is deployed at https://vast-dawn-23202.herokuapp.com/

## Setup

Built using Ruby 2.4.1 and Rails 5.1.3

Install required gems:
`$ bundle install`

Run the following commands to load the database:

```
rake import_dump:load
rake db:migrate
rake db:seed
```

After the import you should see a return value of 1011 when running `Item.count` in the console.

All users have a password of `password` if you want to login and explore.

## Developers
- [Nico Lewis](https://github.com/nico24687)
- [Kelley Jenkins](https://github.com/kelleyjenkins)
- [Lauren Billington](https://github.com/blaurenb)

## Additional Information
The project was developed by the Turing School of Software and Design as a group project for Module 3. More information can be found here: http://backend.turing.io/module3/projects/le_pivot
