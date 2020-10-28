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

5. Once the repo was created, I created and connected it to a P.sh project. 
6. Deploying it fails, because during the `create directus-project` stage, some tables are set up on postgres
7. So I opened a tunnel to postgres, hardcoded the credentials into .env (which I think are already being read from .environment on P.sh).
8. The installation completed fine, and I was able to set up the initial admin user (same as above) for the P.sh service. (Also initializing those tables)
9. Since that set up the db, I could the redeploy the project, giving me a functioning admin panel on P.sh.

Problems still:
- initalize db & admin user on first install
- mount points, check out some common features.
- Local. Whats the best way to do this exactly? just a tunnel? A tunnel works, but still. 
- Local part 2: .env vs. .environment
  - It actually looks as though it is always reading from .env, instead of .environment. 
- template-builder? 