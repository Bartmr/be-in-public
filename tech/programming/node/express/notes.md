- see `tech/frontend/web-development/nextjs/notes.md`
- In case the project is already using singletons
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
        context: ControllerContext<
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

        throw new HttpError(404, {})
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
        context: ControllerContext<
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
