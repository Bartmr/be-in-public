- see `tech/frontend/web-development/nextjs/notes.md`
- In case the project is already using singletons
  - 
    ```typescript
    /*
      since we don't share controller code and it's an abstraction that is not reused,
      this example uses inline functions.
      No need to write function types
    */

    router.get('/notes', 
      withAuthentication({ optional: true }),
      withPermissions({
        roles: [Role.Admin]
      }),
      withController(
        {
          body: z.object({
            id: z.string()
          }),
          query: z.object({}),
          params: z.object({}),
        },
        async (req, res, next, context) => {
          const auth = context.getAuthContext() // throws if withAuthentication({ optional: false | undefined })
          const optionalAuth = context.getOptionalAuthContext()
          const body = context.body
          const query = context.query
          const params = context.params

          res.json({})
        }
      )
    )
    ```
  - 
    ```typescript
    /*
      Controller can be in it's own .controller.ts file,
      but more type declaration and schema code needs to be written down
    */

    const GetNotesBodySchema = z.object({
      id: z.string(),
    });

    const GetNotesQuerySchema = z.object({});

    const GetNotesParamsSchema = z.object({});

    const NotesController = {
      addNote(
        req: AppRequest,
        res: AppResponse,
        next: NextFunction,
        controllerContext: ControllerContext<
          z.Typeof<typeof GetNotesParamsSchema>,
          z.Typeof<typeof GetNotesQuerySchema>,
          z.Typeof<typeof GetNotesBodySchema>
        >
      ) {
        const auth = context.getAuthContext(); // throws if withAuthentication({ optional: false | undefined })
        const optionalAuth = context.getOptionalAuthContext(); // returns undefined if authentication middleware has optional = true
        const body = context.body;
        const query = context.query;
        const params = context.params;

        res.json({})
      },
    };

    router.post(
      "/notes",
      withAuthentication({ optional: true }),
      withPermissions({
        roles: [Role.Admin],
      }),
      withController(
        {
          body: z.object({}),
          query: z.object({}),
          params: z.object({}),
        },
        NotesController.addNote
      )
    );
    ```
