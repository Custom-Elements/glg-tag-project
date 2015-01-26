#glg-tag-project
Place tags on a council member with this element. The logged in user identity
and data connection to epiquery is all inside here, just set the projectid.


    Polymer 'glg-tag-project',

##Events
*TODO* describe the custom event `name` and `detail` that are fired.

      spacePipes: (str) ->
        str?.split('|').join(' | ')

##Attributes and Change Handlers

      projectidChanged: ->
        @$.projecttags.withCredentials = true
        @$.projecttags.url = "#{@src}/getProjectTags.mustache"
        @$.projecttags.params =
          projectId: @projectid
        @$.projecttags.go()

        @$.alltags.withCredentials = true
        @$.alltags.url = "#{@src}/listProjectTags.mustache"
        @$.alltags.go()

##Methods

##Event Handlers
###filterAvailableTags
This takes all the existing tag options, as well as what you just typed
and gives a list of pick values.

      filterAvailableTags: (evt) ->
        matches = @alltags.filter (option) ->
          query = evt.detail?.value?.toLowerCase()
          optionText = option?.name?.toLowerCase()
          optionText.indexOf(query) > -1
        @tagoptions = matches

###[add|remove]tag
This hooks up tag changes to save.

      addtag: (evt, detail) ->
        console.log 'add', detail, @$.user.currentuser
        @$.addtag.method = "POST"
        @$.addtag.withCredentials = true
        @$.addtag.url = "#{@src}/addProjectTag.mustache"
        @$.addtag.params =
          projectId: @projectid
          name: detail.name
          createdBy: @$.user.currentuser.personId
        @$.addtag.go()

      removetag: (evt, detail) ->
        console.log 'remove', detail
        @$.removetag.method = "POST"
        @$.removetag.withCredentials = true
        @$.removetag.url = "#{@src}/deleteProjectTag.mustache"
        @$.removetag.params =
          projectId: @projectid
          name: detail.name
        @$.removetag.go()
