class EventsController < ApplicationController
    def index
        @states = State.all
        @state = State.where(abbreviation: current_user.state)
        @events_in_state = Event.where(state: current_user.state).order(date: :asc)
        @events_in_other_state = Event.where.not(state: current_user.state).order(date: :asc)
        @events_attending = current_user.events_attending
    end

    def show
        @event = Event.find(params[:id])
        @users = @event.users
        @comments = @event.comments
    end

    def create
        user = User.find(current_user.id)
        event = user.events.new(event_params)

        if event.save
            flash[:add_event_success] = "Event Successfully Added"
        else
            flash[:event_name] = event_params[:name]
            flash[:event_date] = event_params[:date]
            flash[:event_city] = event_params[:city]
            flash[:event_state] = event_params[:state]
            flash[:add_event_errors] = event.errors.messages
        end
        redirect_to '/events'
    end

    def edit
        @event = Event.find(params[:id])
        @states = State.all
    end

    def update
        event = Event.find(params[:id])

        if event.update(event_params)
            flash[:update_event_success] = "Event Successfully Updated"
        else
            flash[:event_update_errors] = event.errors.messages
        end
        redirect_to "/events/#{params[:id]}/edit"
    end

    def delete
        event = Event.find(params[:id])
        if event.destroy
            flash[:delete_event_success] = "The '#{event.name}' Event Has Been Deleted"
        else
            flash[:delete_event_success] = "An Error Occured"
        end
        redirect_to "/events"
    end

    def join
        join = current_user.attendees.new(event: Event.find(params[:id]))

        if join.save
            flash[:join_success] = "You Joined The '#{Event.find(params[:id]).name}' Event"
        else
            flash[:join_error] = "An Error Occured"
        end
        redirect_to "/events"
    end

    def cancel
        cancel = Attendee.where(user_id: current_user.id, event_id: params[:id])

        if cancel[0].destroy
            flash[:cancel_success] = "You Cancelled Joining The '#{Event.find(cancel[0].event_id).name}' Event"
        else
            flash[:cancel_error] = "An Error Occured"
        end
        redirect_to "/events"
    end

    private
        def event_params
            params.require(:event).permit(:name, :date, :city, :state)
        end
end
