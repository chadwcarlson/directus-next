https://github.com/directus/next

0. export SHARP_IGNORE_GLOBAL_LIBVIPS=true
1. npm install pg --save
2. yarn create directus-project my-project
3. config
```
? Choose your database client PostgreSQL / Redshift
? Database Host: 127.0.0.1
? Port: 5432
? Database Name: directus
? Database User: postgres
? Database Password: 
? Enable SSL: No


Create your first admin user:
? Email admin@example.com
? Password password
```

looks like these configs get saved to the local .env file

4. Start the server
  ```
  cd /Users/chadcarlson/directus-next
  npx directus start
  ```
